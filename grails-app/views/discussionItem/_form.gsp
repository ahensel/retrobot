<%@ page import="retrobot.DiscussionItem" %>

<div class="discussionItem fieldcontain ${hasErrors(bean: discussionItem, field: 'content', 'error')} ">
    <g:textArea name="content" rows="5" cols="100" autofocus="autofocus" value="${discussionItem?.content}"/>
</div>
