<div class="discussionItemWrapper" style="overflow: hidden">
    <div class="discussionItemNumber">
        ${it.number}
    </div>
    <div class="discussionItem">
        ${it.content}
        <div class="itemEditLink" style="float: right" hidden="true">
            <g:link controller="discussionItem" action="edit" params="[id: it.id]">Edit</g:link>
        </div>
    </div>
</div>
