<%@ page import="retrobot.Poll" %>



<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="poll.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${pollInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'pollItems', 'error')} ">
	<label for="pollItems">
		<g:message code="poll.pollItems.label" default="Poll Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${pollInstance?.pollItems?}" var="p">
    <li><g:link controller="pollItem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="pollItem" action="create" params="['poll.id': pollInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'pollItem.label', default: 'PollItem')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'retrospective', 'error')} required">
	<label for="retrospective">
		<g:message code="poll.retrospective.label" default="Retrospective" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="retrospective" name="retrospective.id" from="${retrobot.Retrospective.list()}" optionKey="id" required="" value="${pollInstance?.retrospective?.id}" class="many-to-one"/>
</div>

