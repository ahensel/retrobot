<%@ page import="retrobot.Retrospective" %>
<!DOCTYPE html>
<html>
    <head>
        %{--<meta name="layout" content="main">--}%
        <g:javascript library="jquery"/>
        <script type="text/javascript">
            function appendItemJustAdded() {
                $('#retroItemJustAdded').show('slow', function() {
                    $('#content').val("").focus();
                    $('#retroItemList').append($(this).html());
                    $(this).html("").hide();
                });
            }
        </script>
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
            <div id="retroItemJustAdded" hidden="hidden"></div>
            <div class="discussionItem" style="border: 1px solid #8080ff; padding:0.5em; margin: 0.5em; background: #ffffee">
                <g:formRemote url="[ controller: 'retrospective', action: 'update']" name="add">
                    <g:textArea name="newDiscussionItem" id="content" rows="5" cols="100" autofocus="autofocus"/>
                    <g:hiddenField name="retroId" value="${retro.id}"/>
                    <div>
                        <g:submitToRemote name="DiscussionItem" value="Add Discussion Item" update="retroItemJustAdded" after="appendItemJustAdded()" action="update" controller="retrospective"/>
                    </div>
                </g:formRemote>
            </div>
        </div>
    </body>
</html>
