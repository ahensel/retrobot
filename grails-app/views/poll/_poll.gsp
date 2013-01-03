<div class="discussionItemWrapper" style="overflow: hidden">
    <div class="discussionItemNumber">
        ${it.number}
    </div>
    <div class="discussionItem" style="padding-left: 40px;">
        ${it.content}
        <br/>
        <div id="poll_${it.number}">
            <g:each in="${it.pollItems}" var="pollItem">
                <label>
                    <g:radio name="poll_${it.number}" value="radio_${pollItem.id}" />
                    ${pollItem.content}
                </label>
                <br/>
            </g:each>
        </div>
        <br/>
        <button>Vote</button>
    </div>
</div>
