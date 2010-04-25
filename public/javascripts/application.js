function fixGridHeight(grid, maxHeight) {
    var gridHeight = $(grid).height();
    if (gridHeight > maxHeight) {
        gridHeight = maxHeight;
    }

    if ($.browser.msie) {
        gridHeight += 1;
    }
    $('.ui-jqgrid-bdiv').height(gridHeight);
}

function addGridButton(grid, placeHolder, buttons) {
    if (!window.isAddGridButtonExecuted) {
        isAddGridButtonExecuted = true;
        for (var b in buttons) {
            button = buttons[b]
            button.onClickButton = eval("(" + button.onClickButton + ")")
            $(grid).navButtonAdd(placeHolder, buttons[b]);
        }
    }
}

function addGridRowButtons(grid, buttons) {
    var ids = $(grid).jqGrid('getDataIDs');

    for (var i=0;i < ids.length;i++) {
        var cl = ids[i];
        for (var b in buttons) {
            button = buttons[b]
            if(button.path) {
                link = '<a title="' + button.title + '" href="' + button.path.replace(/:id/, cl) + '"><span class="ui-icon ' + button.icon + '"></span></a>';
            } else if(button.func) {
                link = '<a title="' + button.title + '" href="javascript:' + button.func.replace(/:id/, cl) + '"><span class="ui-icon ' + button.icon + '"></span></a>';
            }
            options = {};
            options[button.column] = link;
            $(grid).jqGrid('setRowData',ids[i],options);
        }
    }
}

