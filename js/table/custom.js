$('#dashboard_addArticle').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
//"aLengthMenu": [[10, 25, 50, -1], [10,25,50,"All"]],
"order": [[ 2, "desc" ]],
"aLengthMenu": [[10, 25, 50], [10,25,50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "_END_ / _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰ",
"sNext": "��",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );


$('#dashboard_editArticle').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 2, "desc" ]],
"aLengthMenu": [[10, 25, 50], [10,25,50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "_END_ / _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰ",
"sNext": "��",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );


$('#search_record').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 2, "desc" ]],
"aLengthMenu": [[50, 100, -1], [50, 100, "All"]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}

} );