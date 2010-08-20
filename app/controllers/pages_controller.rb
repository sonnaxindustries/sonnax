class PagesController < ApplicationController
  
  def home
  end
  
  def history_and_mission
  end
  
  def international_info
  end
  
  def sonnax_insider
  end
  
  def subscribe_to_email_newsletter
  end
  
  def catalog_request
  end
  
  def directions
  end
  
  def terms_and_conditions    
  end
  
  def news_and_events
  end
  
  def about_us
  end
  
  def how_to_order
  end
  
  def quick_search
    @product_line_parts = ProductLine.all_with_parts
    @product_line_new_parts = ProductLine.all_with_new_parts
    @search_form_presenter = SearchFormPresenter.new(:q => [], :url => search_single_part_path)
  end
  
  def tasc_force
  end
  
  def career_opportunities
  end
  
  def news
  end
  
  def events
  end
  
  def insider
  end
  
  def valve_body_layouts
  end
  
  def pts_testimonies
  end
  
  def pts_faq
  end
  
  def hp_distributors
  end
  
  def publication_glossary
  end
  
  def speed_order
    @cart = find_cart
    @speed_order = SpeedOrder.new
    @product_line_options = ProductLine.speed_order_options
    @selected_product_line = ProductLine.torque_converter
  end
  
  def static_page
    page_template = "pages/static/%s" % [params[:template]]
    render page_template
  end
end