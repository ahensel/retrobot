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
                    $("div.discussionItem", this).hover(function(){$("div.actionItemLink", this).toggle()});

                    $('#content').val("").focus();
                    $("#newDiscussionItemButton").attr('disabled', 'disabled')
                    $('#retroItemList').append($(this).children());
                    $(this).html("").hide();

                    if ($('#pollEditor').css('display') != 'none') {
                        showDiscussionEditor();
                    }
                });
            }

            function showPollEditor() {
                $('#pollEditor').show('slow');
                $('#newPollButton').show();
                $('#newDiscussionItemButton, #classification').hide();
                $("textarea#content").val().trim().length == 0 ? $("#newPollButton").attr('disabled', 'disabled') : $("#newPollButton").removeAttr('disabled');
                $("#newPollItemContent").val("").focus();
            }

            function showDiscussionEditor() {
                $('#pollEditor').hide('slow');
                $('#newPollButton').hide();
                $('#newDiscussionItemButton, #classification').show();
                $("textarea#content").val().trim().length == 0 ? $("#newDiscussionItemButton").attr('disabled', 'disabled') : $("#newDiscussionItemButton").removeAttr('disabled');
            }

            function togglePollEditor() {
                if ($('#pollEditor').css('display') == 'none') {
                    showPollEditor();
                }
                else {
                    showDiscussionEditor();
                }
            }

            function addPollItem() {
                var pollItemContent = $("#newPollItemContent").val();
                $("#pollItems").append("<li>" + pollItemContent + "</li>");
                var pollItemNumber = parseInt($("#pollItemCount").val());
                $("#pollItemCount").val(pollItemNumber + 1);
                $("#pollEditor").append("<input type='hidden' name='pollItem" + pollItemNumber + "' value='" + pollItemContent + "'/>");
                $("#newPollItemContent").val("").focus();
            }

            $(document).ready(function() {
                $("div.discussionItem").hover(function(){$("div.itemEditLink", this).toggle()});
                $("div.discussionItem").hover(function(){$("div.actionItemLink", this).toggle()});

                $("#newPollButton").hide();
                $("#newDiscussionItemButton").attr('disabled', 'disabled');
                $("textarea#content").keyup(function(){
                    $("textarea#content").val().trim().length == 0 ? $("#newDiscussionItemButton, #newPollButton").attr('disabled', 'disabled') : $("#newDiscussionItemButton, #newPollButton").removeAttr('disabled');
                });
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
            <div class="columnContainer">
            <div class="retroItemColumn">
                <div class="columnHeader">
                    Discussion Items
                </div>
                <div id="retroItemList">
                    <g:each in="${retro.retroItems}" var="retroItem">
                        <g:render template="../discussionItem/discussionItem" bean="${retroItem}"/>
                    </g:each>
                </div>
                <g:if test="${retro.isActive}">
                    <div id="retroItemJustAdded" hidden="hidden"></div>
                    <div class="discussionItem">
                        <g:formRemote url="[controller: 'discussionItem', action: 'create']" name="add">
                            <g:textArea name="newRetroItemText" id="content" rows="5" cols="50" maxlength="255" width="100%" autofocus="autofocus"/>
                            <g:hiddenField name="retroId" value="${retro.id}"/>
                            <div id="pollEditor" hidden="hidden">
                                <span style="font-size: 10pt;">Add Poll Items:</span>
                                <ul id="pollItems"></ul>
                                <input type='hidden' id='pollItemCount' name='pollItemCount' value='0'/>
                                <div class="newPollItemDiv" style="margin-bottom: 10px;">
                                    &bull;&nbsp;<g:textField name="newPollItemContent" style="width: 80%;"></g:textField>&nbsp;<button onclick="addPollItem(); return false;">Add</button>
                                </div>
                            </div>

                            <div>
                                <g:submitToRemote name="DiscussionItem" id="newDiscussionItemButton" value="Add Discussion Item" update="retroItemJustAdded" after="appendItemJustAdded()" action="create" controller="discussionItem"/>
                                <g:submitToRemote name="Poll" id="newPollButton" value="Add Poll" update="retroItemJustAdded" after="appendItemJustAdded()" action="create" controller="poll"/>
                                <g:select name="classification" id="classification" optionKey="id" optionValue="value"
                                          from="${Retrospective.DiscussionItemClassifications}"/>
                                <a href="#" onclick="togglePollEditor()" style="font-size: 12px; float: right;">Poll</a>
                            </div>
                        </g:formRemote>
                    </div>
                </g:if>
            </div>
            <div class="actionItemColumn">
                <div class="columnHeader">
                    Action Items
                </div>
                <div id="actionItemList">
                    <g:each in="${retro.actionItems}" var="actionItem">
                        <g:render template="../actionItem/actionItem" bean="${actionItem}"/>
                    </g:each>
                </div>
            </div>
            </div>
        </div>
    </body>
</html>
