<div class="actionItem">

    <div class="itemEditLink" style="float: right" hidden="true">
        <g:link controller="actionItem" action="edit" params="[id: it.id]"><g:img dir="images" file="Wrench.png" width="16" height="16"></g:img></g:link>
    </div>

    <div>
        <div class="discussionItemNumber" style="font-size: 9pt; padding-top:0; padding-bottom:0; margin-bottom:0; margin-right:0;">
            ${it.discussionItem.number}
        </div>

        <div class="actionItemDiscussionContent discussionItemType${it.discussionItem.classification}">
            ${it.discussionItem.content}
        </div>
    </div>
    ${it.content}
</div>