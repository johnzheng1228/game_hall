/**
 * Created with JetBrains RubyMine.
 * User: johnzheng
 * Date: 13-9-25
 * Time: 下午5:23
 * To change this template use File | Settings | File Templates.
 */
 function search(){
   var currTab = $('#tabs').tabs('getSelected');
   alert(currTab);
}

function showDialog(title, href) {
    $('#dlg').dialog({
     title: title,
     href: href,
     width: 600,
     height: 400,
     modal: true,
     buttons: [{
        text: '保存',
        handler: function () {
            $("#submitFrm").form({
                success: function(result){
                    var rst = eval("("+result+")");
                    if(rst.errorMsg){
                        $('#error_explanation span').html(rst.errorMsg);
                    }else{
                        $('#dlg').dialog('close');
                        $('#dg').datagrid('reload');
                    }
                }
            })
            $("#submitFrm").submit();}
        },
        {
            text:"取消",
            handler: function(){
                $('#dlg').dialog('close');
            }
        }]
    });
}