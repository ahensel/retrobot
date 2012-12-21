<%@ page import="retrobot.Retrospective; retrobot.DiscussionItem" %>

<div class="discussionItem fieldcontain ${hasErrors(bean: discussionItem, field: 'content', 'error')} ">
    <g:textArea name="content" rows="5" cols="100" maxlength="255" autofocus="autofocus" value="${discussionItem?.content}"/>
</div>
<g:select name="classification" id="classification" optionKey="id" optionValue="value"
          from="${Retrospective.DiscussionItemClassifications}" value="${discussionItem?.classification}"/>

<g:checkBox name="isRecurring" value="${discussionItem?.isRecurring}" />
<label for="isRecurring">Recurring</label>
