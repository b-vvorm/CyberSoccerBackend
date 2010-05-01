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
      :controller => controller_name,
      :grid_data => url_for(:action => "grid_data"),
      :grid_loaded => "gridLoadHandler",
      :error_handler => "gridErrorHandler",
      :rownumbers => true,
      :delete => false,
      :edit => false,
      :add => false,
      :view => false,
      :search => false,
      :connect => false
    }.merge(options)

    show_add = options.delete(:add)

    width = get_width(options, fields)
    row_buttons = options.delete(:row_buttons) || []
    grid_buttons = options.delete(:grid_buttons) || []
    row_buttons += get_row_buttons(options)
    grid_buttons += get_grid_buttons(show_add, options)

    fields << { :field => "action_view", :label => "", :width => 14, :search => false } if options.delete(:view)
    fields << { :field => "action_edit", :label => "", :width => 14, :search => false } if options.delete(:edit)
    fields << { :field => "action_delete", :label => "", :width => 14, :search => false } if options.delete(:delete)
    fields << { :field => "action_connect", :label => "", :width => 14, :search => false } if options.delete(:connect)

    output = jqgrid(title, grid_name, options[:grid_data], fields, options)

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

  def get_row_buttons(options)
    buttons = []
    if options.include?(:view)
      buttons << {
        :path => url_for(:controller => options[:controller], :action => "show", :id => ":id"),
        :title => t("view", :scope => options[:controller]),
        :icon => "ui-icon-comment",
        :column => "action_view"
      }
    end

    if options.include?(:edit)
      buttons << {
        :path => url_for(:controller => options[:controller], :action => "edit", :id => ":id"),
        :title => t("edit", :scope => options[:controller]),
        :icon => "ui-icon-pencil",
        :column => "action_edit"
      }
    end

    if options.include?(:delete)
      buttons << {
        :func => "$.ajax({url: '#{url_for(:action => :destroy, :id => ':id')}', type: 'post', dataType:'script', data: { '_method': 'delete' }}); return false;",
        :title => t("delete", :scope => options[:controller]),
        :icon => "ui-icon-trash",
        :column => "action_delete"
      }
    end

    if options.include?(:connect)
      buttons << {
        :path => url_for(:controller => options[:controller], :action => "connect", :id => ":id"),
        :title => t("connect", :scope => options[:controller]),
        :icon => "ui-icon-star",
        :column => "action_connect"
      }
    end

    buttons
  end

  def get_grid_buttons(show_add, options)
    buttons = []
    buttons << {
      :buttonicon => "ui-icon-plus",
      :caption => "",
      :title => t("create", :scope => options[:controller]),
      :onClickButton => "function(){ window.location = '#{url_for :action => "new"}'}",
      :position => "first"
    } if show_add
    buttons
  end
end

