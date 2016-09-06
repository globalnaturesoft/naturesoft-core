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
    
    # display user box
    def user_box(user)
      html = '<span class="align_center" style="display: inline">' +
            '<img width="30" src="' + image_src(user.image.system).to_s + '" class="img-circle" alt="">' +
            '<br />' + user.display_name +
        '</span>';
      return html.html_safe
    end
    
    # display date
    def display_date(datetime)
      return datetime.strftime("%d/%m/%Y")
    end
    
    # convert string to url friendly string
    def url_friendly(string)
      string.unaccent.downcase.to_s.gsub(/[^0-9a-z ]/i, '').gsub(/ +/i, '-').strip
    end
    
    # render content to position
    def position(pos)
      text = ""
      @modules = Naturesoft::Nsmodule.get_by_position(pos)
      @modules.each do |mod|
        text += render("naturesoft/"+mod.engine_name+"/admin/nsmodules/"+mod.module_name+"/show", nsmodule: mod)
      end
      text.html_safe
    end
    
    # recursive rows
    def recursive_rows(rows, deep, view, top=false)
      text = ""
      rows.each do |row|
        text += render(view, item: row, top: top)
        if (deep != 1) and !row.children.empty?
          text += recursive_rows(row.children, deep-1, view)
        end
      end
      text.html_safe
    end
  end
end
