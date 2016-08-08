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
          'class': 'default'
        },
      }
      return "<span class=\"label label-#{statuses[:"#{status}"][:'class']}\">#{statuses[:"#{status}"][:'label']}</span>".html_safe
    end
    
    # display button enable/disable for status
    def display_btn_status(status)
      statuses = {
        'active': {
          'label': 'Disable',
          'class': 'lock2'
        },
        'inactive': {
          'label': 'Enable',
          'class': 'unlocked2'
        },
      }
      return "<i class=\"icon-#{statuses[:"#{status}"][:'class']}\"></i> #{statuses[:"#{status}"][:'label']}".html_safe
    end
  end
end
