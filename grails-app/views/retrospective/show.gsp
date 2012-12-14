<%@ page import="retrobot.Retrospective" %>
<!DOCTYPE html>
<html>
    <head>
        %{--<meta name="layout" content="main">--}%
        <g:javascript library="jquery"/>
        <r:layoutResources/>
    </head>
    <body>
        <div class="retrospective" style="border: 1px solid #ffc8c8; padding:1em; margin: 1em; background: #fff5f5" id="retro">
            Foo team retrospective, Fri, Jan 4, 2013
            <div id="retroItemList">
                <g:each in="${retro.discussionItems}" var="discussionItem">
                    <g:render template="discussionItem" bean="${discussionItem}"/>
                </g:each>
            </div>
            %{--<div class="discussionItem" style="border: 1px solid #8080ff; padding:0.5em; margin: 0.5em; background: #ffffee">--}%
                %{--<g:textArea name="newDiscussionItem" rows="5" cols="100"/>--}%
                %{--<div>--}%
                    %{--<button onclick="addDiscussionItem()">Add discussion item</button>--}%
                    %{--<button disabled="disabled">Add poll</button>--}%
                %{--</div>--}%
            %{--</div>--}%
            %{--<div class="discussionItem" style="border: 1px solid #8080ff; padding:0.5em; margin: 0.5em; background: #ffffee">--}%
                %{--<g:form action="update" id="${params.id}">--}%
                    %{--<g:textArea name="newDiscussionItem" id="content" rows="5" cols="100"/>--}%
                    %{--<div>--}%
                        %{--<g:form name="addDiscussionItem">--}%
                            %{--<g:hiddenField name="retroId" value="${retro.id}"/>--}%
                            %{--<g:submitButton name="add" value="Add Discussion Item"/>--}%
                        %{--</g:form>--}%
                    %{--</div>--}%
                %{--</g:form>--}%
            %{--</div>--}%
        %{--</div>--}%

            <div class="discussionItem" style="border: 1px solid #8080ff; padding:0.5em; margin: 0.5em; background: #ffffee">
                <g:formRemote url="[ controller: 'retrospective', action: 'update']" name="add">
                    <g:textArea name="newDiscussionItem" id="content" rows="5" cols="100"/>
                    <g:hiddenField name="retroId" value="${retro.id}"/>
                    <div>
                        <g:submitToRemote name="DiscussionItem" value="Add Discussion Item" update="retroItemList" action="update" controller="retrospective"/>
                    </div>
                </g:formRemote>
            </div>
        </div>
    </body>
</html>
