<div class="discussionItemWrapper" style="overflow: hidden">
    <div class="discussionItemNumber">
        ${it.number}
    </div>
    <div class="discussionItem">
        ${it.content}
        <div class="itemEditLink" style="float: right" hidden="true">
            <g:link controller="discussionItem" action="edit" params="[id: it.id]"><g:img dir="images" file="Wrench.png" width="16" height="16"></g:img></g:link>
        </div>

        <div class="actionItemLink" style="float: right; padding-right: 5px" hidden="true">
            <g:link controller="actionItem" action="create" params="[discussionId: it.id]"><g:img dir="images" file="Add.png" width="16" height="16"></g:img></g:link>
        </div>
    </div>
</div>
