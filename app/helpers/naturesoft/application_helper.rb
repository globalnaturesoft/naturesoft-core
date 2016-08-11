module Naturesoft
  module ApplicationHelper
    def active(path)
      current_page?(path) ? 'active' : ''
    end
    
    def title(page_title)
      content_for :title, page_title.to_s
    end
    
    def format_number(number, vn = false, round = false, precision = nil)
      prec = (number.to_f.round == number.to_f) ? 0 : 2
      prec = 0 if round
      
      if !precision.nil?
        prec = precision
      end
    
      if vn
        number_to_currency(number, precision: prec, separator: ",", unit: '', delimiter: ".")
      else
        number_to_currency(number, precision: prec, separator: ".", unit: '', delimiter: ",")
      end
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
    
    # display image src
    def image_src(image)
      if !image.present?
        url_for("/backend/assets/images/placeholder.jpg")
      else
        image
      end
    end
    
  end
end
