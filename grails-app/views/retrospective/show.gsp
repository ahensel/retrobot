<%@ page import="retrobot.Retrospective" %>
<!DOCTYPE html>
<html>
    <head>
        %{--<meta name="layout" content="main">--}%

        <link rel="stylesheet" href="<g:createLinkTo dir='css' file='retro.css'/>"/>

        <g:javascript library="jquery"/>
        <r:layoutResources/>

        <script type="text/javascript">
            function appendItemJustAdded() {
                $('#retroItemJustAdded').show('slow', function() {
                    $('#content').val("").focus();
                    $('#retroItemList').append($(this).html());
                    $(this).html("").hide();
                });
            }
        </script>
    </head>
    <body>
        <div class="sidebar">
            <g:each in="${previousRetros}" var="previousRetro">
                <g:link controller="retrospective" action="show" id="${previousRetro.id}">Retrospective ${previousRetro.id}</g:link>
                <br/>
            </g:each>
            <g:link controller="retrospective" action="show">Current Retro</g:link>
        </div>
        <div class="retrospective" id="retro">
            Foo team retrospective
            <div id="retroItemList">
                <g:each in="${retro.discussionItems}" var="discussionItem">
                    <g:render template="discussionItem" bean="${discussionItem}"/>
                </g:each>
            </div>
            <g:if test="${retro.isActive}">
                <div id="retroItemJustAdded" hidden="hidden"></div>
                <div class="discussionItem">
                    <g:formRemote url="[controller: 'retrospective', action: 'update']" name="add">
                        <g:textArea name="newDiscussionItem" id="content" rows="5" cols="100" autofocus="autofocus"/>
                        <g:hiddenField name="retroId" value="${retro.id}"/>
                        <div>
                            <g:submitToRemote name="DiscussionItem" value="Add Discussion Item" update="retroItemJustAdded" after="appendItemJustAdded()" action="update" controller="retrospective"/>
                        </div>
                    </g:formRemote>
                </div>
                <div>
                    <g:form url="[controller: 'retrospective', action: 'close']" name="close">
                        <g:hiddenField name="retroId" value="${retro.id}"/>
                        <g:submitButton name="Retrospective" value="Close Retro"/>
                    </g:form>
                </div>
            </g:if>
        </div>
    </body>
</html>
