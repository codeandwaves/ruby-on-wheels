
require 'uri'
require 'net/http'
require 'json'
require 'ruby-progressbar'

class EtlScript

  NHTSA_BASE_PATH = "https://vpic.nhtsa.dot.gov/api/"
  OUTPUT_API_FORMAT = "?format=json"
  GET_CARS_ENDPOINT = "vehicles/getallmakes"
  GET_CAR_MAKERS_ENDPOINT = "vehicles/GetModelsForMakeId/"
  TOTAL_CARS = 100
  TOTAL_MODELS_PER_CAR = 10
  OUTPUT_FILE_LOCATION = File.join(Rails.root, 'db')

  def self.go

    data = fetch_data_from_api

    data = format_data_to_json(data)

    write_to_file(data)
  end

  ##
  #  Load Car's information and Car's model information from NHTSA api
  #
  def self.fetch_data_from_api
    puts "Loading #{TOTAL_CARS} car makers"
    car_makers = get_car_makers_from_api
    progressbar = ProgressBar.create(title: "Loading #{TOTAL_MODELS_PER_CAR} car models for each car maker ", total: car_makers.size, format: '%t%e %w', rate_scale: lambda { |rate| rate * TOTAL_MODELS_PER_CAR })
    result = {}
    begin
      car_makers.each do |car_maker_id, car_maker_name|
        result[car_maker_name] = get_car_models_from_api(car_maker_id, car_maker_name)
        progressbar.increment
      end
    rescue StandardError => e
      puts e
    end
    result
  end

  ##
  # Format output hash from car and models information
  #
  # expected output: [
  # {
  #   'brand': 'Tesla', // A random brand
  #   'name': 'Roadster' // A random model's name from the selected brand
  # },
  # {
  #   'brand': 'Bmw', // A random brand
  #   'name': '328i' // A random model's name from the selected brand
  # }
  #  // ....
  # ]
  def self.format_data_to_json(data)
    result = []

    data.each do |car_maker_name, car_maker_models|
      car_maker_models.each do |car_maker_model|
        result << {
          'brand' => car_maker_name,
          'name' => car_maker_model
        }
      end
    end

    result
  end

  def self.write_to_file(data)
    puts data.size
    File.write("#{OUTPUT_FILE_LOCATION}/cars.json", JSON.pretty_generate(data))
  end

  ##
  # Performs a GET HTTP call to NHTSA api to fetch 100 cars
  #
  # The response body is parsed as a JSON object into a Ruby hash.
  #
  # This implementation does not handle any HTTP errors.
  # Example: get_car_makers_from_api(total_results: 100)
  def self.get_car_makers_from_api(total_results: TOTAL_CARS)
    result = api_call(GET_CARS_ENDPOINT)

    # {440=>"Aston Martin", 441=>"Tesla", ...}
    format_output(result["Results"], hash_key: "Make_ID", hash_value: "Make_Name").first(total_results).to_h
  end

  ##
  # Performs an HTTP call to NHTSA api to fetch 10 models from a specific car maker
  #
  # The response body is parsed as a JSON object into a Ruby hash.
  #
  # This implementation doesn't handle any HTTP errors.
  # Example: get_car_models_from_api(50)
  def self.get_car_models_from_api(maker_id, maker_name)
    return unless maker_id

    result = api_call(GET_CAR_MAKERS_ENDPOINT + maker_id.to_s)

    # eg. [{"Make_ID"=>442, "Make_Name"=>"JAGUAR", "Model_ID"=>2242, "Model_Name"=>"XJ"}, ...]
    format_output(result["Results"], hash_key: "Model_Name", hash_value: "Model_ID").first(TOTAL_MODELS_PER_CAR).to_h.keys
  end

  # format output from NHTSA api
  # eg.
  # input(data, "Make_ID", "Make_Name") -> [{"Make_ID"=>440, "Make_Name"=>"ASTON MARTIN"}, {"Make_ID"=>441, "Make_Name"=>"TESLA"},..]
  # output -> [{440=>"Aston Martin", 441=>"Tesla"},...]
  def self.format_output(data, hash_key: nil, hash_value: nil)
    return {} if hash_key.nil? || hash_value.nil?
    result = {}

    data&.each do |r|
      next unless r[hash_key]
      result[r[hash_key]] = r[hash_value].respond_to?(:titleize) ? r[hash_value]&.titleize : r[hash_value]
    end
    result
  end

  def self.api_call(endpoint)
    uri = URI.parse(NHTSA_BASE_PATH + endpoint + OUTPUT_API_FORMAT)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    JSON.parse(http.get(uri.request_uri).body)
  end

  private_class_method :get_car_makers_from_api
  private_class_method :get_car_models_from_api
  private_class_method :format_output
  private_class_method :api_call
end