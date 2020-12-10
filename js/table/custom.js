$('#dashboard_addArticle').DataTable({
//跟数组下标一样，第一列从0开始，这里表格初始化时，第四列默认降序
//"aLengthMenu": [[10, 25, 50, -1], [10,25,50,"All"]],
"order": [[ 2, "desc" ]],
"aLengthMenu": [[10, 25, 50], [10,25,50]],
"oLanguage": {
"sSearch": "搜索：",
"sLengthMenu": "每页显示 _MENU_ 条记录",
"sZeroRecords": "抱歉， 没有找到",
"sInfo": "_END_ / _TOTAL_ 条数据",
"sInfoEmpty": "没有数据",
"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
"oPaginate": {
"sFirst": "首页",
"sPrevious": "前",
"sNext": "后",
"sLast": "尾页"
},
"sZeroRecords": "没有检索到数据",
"sProcessing": "<img src='./loading.gif' />"
}
} );


$('#dashboard_editArticle').DataTable({
//跟数组下标一样，第一列从0开始，这里表格初始化时，第四列默认降序
"order": [[ 2, "desc" ]],
"aLengthMenu": [[10, 25, 50], [10,25,50]],
"oLanguage": {
"sSearch": "搜索：",
"sLengthMenu": "每页显示 _MENU_ 条记录",
"sZeroRecords": "抱歉， 没有找到",
"sInfo": "_END_ / _TOTAL_ 条数据",
"sInfoEmpty": "没有数据",
"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
"oPaginate": {
"sFirst": "首页",
"sPrevious": "前",
"sNext": "后",
"sLast": "尾页"
},
"sZeroRecords": "没有检索到数据",
"sProcessing": "<img src='./loading.gif' />"
}
} );


$('#search_record').DataTable({
//跟数组下标一样，第一列从0开始，这里表格初始化时，第四列默认降序
"order": [[ 2, "desc" ]],
"aLengthMenu": [[50, 100, -1], [50, 100, "All"]],
"oLanguage": {
"sSearch": "搜索：",
"sLengthMenu": "每页显示 _MENU_ 条记录",
"sZeroRecords": "抱歉， 没有找到",
"sInfo": "从 _START_ 到 _END_ /共 _TOTAL_ 条数据",
"sInfoEmpty": "没有数据",
"sInfoFiltered": "(从 _MAX_ 条数据中检索)",
"oPaginate": {
"sFirst": "首页",
"sPrevious": "前一页",
"sNext": "后一页",
"sLast": "尾页"
},
"sZeroRecords": "没有检索到数据",
"sProcessing": "<img src='./loading.gif' />"
}

} );