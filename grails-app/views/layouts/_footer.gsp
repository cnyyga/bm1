<hr>

<div class="modal hide fade" id="myModal">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>Settings</h3>
    </div>
    <div class="modal-body">
        <p>Here settings can be configured...</p>
    </div>
    <div class="modal-footer">
        <a href="#" class="btn" data-dismiss="modal">Close</a>
        <a href="#" class="btn btn-primary">Save changes</a>
    </div>
</div>
<div id="confirmDialog"  title="Basic dialog">
    <h3><g:message code="default.button.delete.confirm.message"/>  </h3>
</div>
<%
    def footCal = Calendar.instance
    def footYear = footCal.get(Calendar.YEAR)
    %>
<footer>
    <p class="pull-left">&copy; <a href="http://www.zscollege.com/" target="_blank">${message(code: 'default.school.name')}</a> ${footYear}</p>
</footer>