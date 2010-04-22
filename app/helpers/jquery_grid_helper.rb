# Provides helper methods for jquery ajax grid integration.
module JqueryGridHelper

  DEFAULT_GRID_WIDTH = 200

  # Includes jquery grid javascripts.
  def jqgrid_includes
    locale = I18n.locale rescue :en
    javascript_merged "jqgrid/i18n/grid.locale-#{locale}", "grid"
    stylesheet_merged :jqgrid
  end

  # Renders helper javascript method for grid with new, edit, view and delete buttons.
  def jquery_custom_grid(fields, options = {}, title = "", grid_name = controller_name)

    # Default options
    options = {
      :edit_url => url_for(:action => "grid_edit"),
      :grid_loaded => "gridLoadHandler",
      :error_handler => "gridErrorHandler",
      :rownumbers => true,
      :delete => false,
      :edit => false,
      :add => false,
      :view => false,
      :search => false
    }.merge(options)

    show_add = options.delete(:add)
    show_view = options.delete(:view)
    show_edit = options.delete(:edit)
    show_delete = options.delete(:delete)
    width = get_width(options, fields)
    row_buttons = options.delete(:row_buttons) || []
    grid_buttons = options.delete(:grid_buttons) || []
    row_buttons += get_row_buttons(show_view, show_edit, show_delete)
    grid_buttons += get_grid_buttons(show_add)

    fields << { :field => "action_view", :label => "", :width => 14, :search => false } if show_view
    fields << { :field => "action_edit", :label => "", :width => 14, :search => false } if show_edit
    fields << { :field => "action_delete", :label => "", :width => 14, :search => false } if show_delete

    output = jqgrid(title, grid_name, url_for(:action => "grid_data"), fields, options)

    output << %Q(
      <script type="text/javascript">

        $(function() {
          $("##{grid_name}").jqGrid('setGridWidth', #{width});
        });

        function gridLoadHandler() {
          fixGridHeight('##{grid_name}', 400)
          #{add_row_buttons(grid_name, row_buttons)}
          #{add_grid_buttons(grid_name, grid_buttons)}
        }

      </script>
    )
  end

  def add_row_buttons(grid_name, buttons)
    output = StringIO.new
    output << "addGridRowButtons('##{grid_name}',["
    output << (buttons.collect {|b| b.to_json}).join(",")
    output << "]);"
    output.string
  end

  def add_grid_buttons(grid_name, buttons)
    output = StringIO.new
    output << "addGridButton('##{grid_name}', '#pg_#{grid_name}_pager', ["
    output << (buttons.collect {|b| b.to_json}).join(",")
    output << "]);"
    output.string
  end

  def get_width(options, fields)
    width = options.delete(:width)
    width = fields.inject(DEFAULT_GRID_WIDTH) {|sum, field| sum + field[:width]} unless width
  end

  def get_row_buttons(show_view, show_edit, show_delete)
    buttons = []
    if show_view
      buttons << {
        :path => url_for(:action => "show", :id => ":id"),
        :title => t("view_details", :scope => @controller.controller_path.split("/")),
        :icon => "ui-icon-comment",
        :column => "action_view"
      }
    end

    if show_edit
      buttons << {
        :path => url_for(:action => "edit", :id => ":id"),
        :title => t("edit", :scope => @controller.controller_path.split("/")),
        :icon => "ui-icon-pencil",
        :column => "action_edit"
      }
    end

    if show_delete
      buttons << {
        :path => url_for(:action => "destroy", :id => ":id", :method => "DELETE"),
        :title => t("delete", :scope => @controller.controller_path.split("/")),
        :icon => "ui-icon-trash",
        :column => "action_delete"
      }
    end
    buttons
  end

  def get_grid_buttons(show_add)
    buttons = []
    buttons << {
      :buttonicon => "ui-icon-plus",
      :caption => "",
      :title => t(".create_new"),
      :onClickButton => "function(){ window.location = '#{url_for :action => "new"}'}",
      :position => "first"
    } if show_add
    buttons
  end
end

