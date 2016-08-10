module Naturesoft
  module ApplicationHelper
    def active(path)
      current_page?(path) ? 'active' : ''
    end
    
    def title(page_title)
      content_for :title, page_title.to_s
    end
    
    # display status
    def display_status(status)
      statuses = {
        'active': {
          'label': 'Active',
          'class': 'success'
        },
        'inactive': {
          'label': 'Inactive',
          'class': 'danger'
        },
      }
      return "<span class=\"label label-#{statuses[:"#{status}"][:'class']}\">#{statuses[:"#{status}"][:'label']}</span>".html_safe
    end
    
    # display image
    def image_src(image)
      if !image.present?
        url_for("/backend/assets/images/placeholder.jpg")
      else
        image
      end
    end
    
  end
end
