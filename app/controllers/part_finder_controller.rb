class PartFinderController < ActionController::Base
  def redirect
    if params[:pl] && !params[:pl].blank?
      product_line = Legacy::ProductLine.find(params[:pl])
      new_product_line = product_line._model_record
    end

    if params[:unit] && !params[:unit].blank?
      unit = Legacy::Unit.find(params[:unit])
      new_unit = unit._model_record
    end

    if params[:make] && !params[:make].blank?
      make = Legacy::Make.find(params[:make])
      new_make = make._model_record
    end

    if new_product_line && new_unit && new_make
      redirect_to filter_product_line_parts_path(new_product_line.url_friendly, :"filter[unit]" => new_unit.id, :"filter[make]" => new_make.id)
      return false
    end

    if new_product_line && new_make
      redirect_to filter_product_line_parts_path(new_product_line.url_friendly, :"filter[make]" => new_make.id)
      return false
    end

    if new_product_line && !new_make && !new_unit
      if params[:new_only] && params[:new_only] == 'true'
        redirect_to recent_product_line_parts_path(new_product_line.url_friendly)
        return false
      else
        path_name = "%s_path" % [new_product_line.url_friendly.underscore]
        redirect_to(send(path_name))
        return false
      end
    end
    redirect_to root_url
  end

  def part_summary_redirect
    if params[:pl] && !params[:pl].blank?
      product_line = Legacy::ProductLine.find(params[:pl])
      new_product_line = product_line._model_record
    end

    if params[:unit] && !params[:unit].blank?
      unit = Legacy::Unit.find(params[:unit])
      new_unit = unit._model_record
    end

    if params[:make] && !params[:make].blank?
      make = Legacy::Make.find(params[:make])
      new_make = make._model_record
    end

    if params[:id] && !params[:make].blank?
      part = Legacy::Part.find(params[:id])
      new_part = part._model_record
    end

    if new_product_line && new_part
      redirect_to product_line_part_path(new_product_line.url_friendly, new_part.id)
      return false
    end

    redirect_to(root_url)
  end
end
