<%@ page import="retrobot.ActionItem" %>

<div class="discussionItemFormDisplay">
    %{--<g:textArea readonly= "readonly" name="discussionContent" value="${discussionItem.content}"/>--}%
    <g:if test="${discussionItem?.content}">
        ${discussionItem.content}
    </g:if>
    <g:else>
        ${actionItemInstance.discussionItem.content}
    </g:else>
</div>

<div class="discussionItem fieldcontain ${hasErrors(bean: actionItemInstance, field: 'content', 'error')} ">
    <g:textArea name="content" rows="5" cols="100" maxlength="255" autofocus="autofocus" value="${actionItemInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: actionItemInstance, field: 'owners', 'error')} required">
	<label for="owners">
		<g:message code="actionItem.owners.label" default="Owners" />
		<span class="required-indicator">*</span>
	</label>

    <g:if test="${actionItemInstance?.id}">
        <g:set var="owners" value="${actionItemInstance?.owners[0]}"/>
    </g:if>
    <g:else>
        <g:set var="owners" value=""/>
    </g:else>

    <g:textField name="owners" value="${owners}"/>

    %{--<g:textField name="owners" value="${actionItemInstance?.owners[0]}"/>--}%
</div>
<g:if test="${discussionItem?.id}">
    <g:hiddenField name="discussionItemId" value="${discussionItem.id}"/>
</g:if>
<g:else>
    <g:hiddenField name="discussionItemId" value="${actionItemInstance.discussionItem.id}"/>
</g:else>
%{--<g:hiddenField name="retroId" value="${retro.id}"/>--}%


