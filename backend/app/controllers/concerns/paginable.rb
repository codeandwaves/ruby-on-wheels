module Paginable
  protected

  def links_paginated_options links_paths, resources
    {
      links: {
        first: send(links_paths, page: 1),
        last: send(links_paths, page: resources.total_pages),
        prev: send(links_paths, page: resources.prev_page),
        next: send(links_paths, page: resources.next_page),
      }
    }
  end

  def current_page
    (params[:page] || 1).to_i
  end

  def per_page
    (params[:per_page] || PER_PAGE).to_i
  end
end