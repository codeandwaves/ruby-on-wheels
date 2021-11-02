class BaseSerializer < Blueprinter::Base
  identifier :id

  # Override render method from Blueprinter::Base to format response.
  def self.render(object, links = {})
    return {} if object.try(:empty?)

    serializer_klass = resource_serializer_class(object)
    # {
    #   "data" => serializer_klass.render_as_json(object)
    # }.merge!(links)
    serializer_klass.render_as_json(object)
  end

  def self.resource_serializer_class(object)
    object_klass = (object.try(:first) || object).class.to_s.downcase

    "#{ object_klass }_serializer".classify.constantize
  end

  private_class_method :resource_serializer_class

end
