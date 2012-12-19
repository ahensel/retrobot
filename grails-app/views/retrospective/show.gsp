<%@ page import="retrobot.Retrospective" %>
<!DOCTYPE html>
<html>
    <head>
        %{--<meta name="layout" content="main">--}%

        <link rel="stylesheet" href="<g:createLinkTo dir='css' file='retro.css'/>"/>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
        <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>

        <g:javascript library="jquery"/>
        <r:layoutResources/>

        <script type="text/javascript">
            function appendItemJustAdded() {
                $('#retroItemJustAdded').show('slow', function() {
                    $("div.discussionItem", this).hover(function(){$("div.itemEditLink", this).toggle()});

                    $('#content').val("").focus();
                    $('#retroItemList').append($(this).children());
                    $(this).html("").hide();
                });
            }

            $(document).ready(function() {
                $("div.discussionItem").hover(function(){$("div.itemEditLink", this).toggle()})
            });
        </script>
    </head>
    <body>
        <div class="sidebar">
            <g:link controller="retrospective" action="show">Current Retro</g:link>
            <br/><br/>
            <g:each in="${previousRetros}" var="previousRetro">
                <g:link controller="retrospective" action="show" id="${previousRetro.id}">Retrospective ${previousRetro.id}</g:link>
                <br/>
            </g:each>
        </div>
        <div class="retrospective" id="retro">
            <div class="retroHeader">
                Foo team retrospective
                <span style="float: right">
                    <g:form url="[controller: 'retrospective', action: 'close']" name="close">
                        <g:hiddenField name="retroId" value="${retro.id}"/>
                        <g:submitButton name="Retrospective" value="Close Retro"/>
                    </g:form>
                </span>
                <hr style="border: 1px solid #808080">
            </div>
            <div class="retroItemColumn">
                <div class="columnHeader">
                    Discussion Items
                </div>
                <div id="retroItemList">
                    <g:each in="${retro.discussionItems}" var="discussionItem">
                        <g:render template="discussionItem" bean="${discussionItem}"/>
                    </g:each>
                </div>
                <g:if test="${retro.isActive}">
                    <div id="retroItemJustAdded" hidden="hidden"></div>
                    <div class="discussionItem">
                        <g:formRemote url="[controller: 'retrospective', action: 'update']" name="add">
                            <g:textArea name="newDiscussionItem" id="content" rows="5" cols="50" width="100%" autofocus="autofocus"/>
                            <g:hiddenField name="retroId" value="${retro.id}"/>
                            <div>
                                <g:submitToRemote name="DiscussionItem" value="Add Discussion Item" update="retroItemJustAdded" after="appendItemJustAdded()" action="update" controller="retrospective"/>
                            </div>
                        </g:formRemote>
                    </div>
                </g:if>
            </div>
            <div class="retroItemColumn">
                <div class="columnHeader">
                    Action Items
                </div>
                <div id="actionItemList">
                    <g:each in="${retro.actionItems}" var="actionItem">
                        <g:render template="actionItem" bean="${actionItem}"/>
                    </g:each>
                </div>
            </div>
        </div>
    </body>
</html>
