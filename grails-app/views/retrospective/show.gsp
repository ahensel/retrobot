<%@ page import="grails.converters.JSON; retrobot.Retrospective" %>
<!DOCTYPE html>
<html ng-app>
    <head>
        %{--<meta name="layout" content="main">--}%

        <link rel="stylesheet" href="<g:createLinkTo dir='css' file='retro.css'/>"/>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
        <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>

        <g:javascript library="jquery"/>
        <r:layoutResources/>

        <script src="http://localhost:8787/scripts/bart.js"></script>
        <script src="js/angular.js"></script>
        <script type="text/javascript">


            function thisRetroTopic() {
                return thisProjectTopic() + "/" + $("#retroId").val();
            }

            function thisProjectTopic() {
                return "/rally/retro/projectFoo";
            }

            function publish(topic, message) {
                Bart.connect(function () {
                    Bart.publish(topic, message);
                });
            }


            function pollEditorIsShown() {
                return $('#pollEditor').css('display') != 'none';
            }

            function showPollEditor() {
                $('#pollEditor').show('slow');
                $('#newPollButton').show();
                $('#newDiscussionItemButton, #classification').hide();
                disableSubmitButtonsIfNoContent();
                $("#newPollItemContent").val("").focus();
            }

            function showDiscussionEditor() {
                $('#pollEditor').hide('slow');
                $('#newPollButton').hide();
                $('#newDiscussionItemButton, #classification').show();
                disableSubmitButtonsIfNoContent();
            }

            function disableSubmitButtonsIfNoContent() {
                var buttons = $("#newDiscussionItemButton, #newPollButton");
                $("textarea#content").val().trim().length == 0 ? buttons.attr('disabled', 'disabled') : buttons.removeAttr('disabled');
            }

            function togglePollEditor() {
                if (pollEditorIsShown()) {
                    showDiscussionEditor();
                }
                else {
                    showPollEditor();
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
                Bart.connect(function () {
                    Bart.subscribe(thisRetroTopic(), function (message) {
                        if (message.type === 'appendDiscussionItem') {
                            appendDiscussionItem(message.item);
                        }
                        else if (message.type === 'changeRetroName') {
                            $("#retroName").text(message.item);
                            $("#retroNameField").val(message.item);
                        }
                    });
                    Bart.subscribe(thisProjectTopic(), function (message) {
                        alert("project change alert, type = " + message.type);
                    });
                });

                $('#retroNameField').on('keydown', function(e) {
                    if (e.which == 13) {
                        e.preventDefault();
                        enterRetroName();
                    }
                    else if (e.which == 27) {
                        e.preventDefault();
                        escapeRetroName();
                    }
                });

                $('#retroName').text('${retro.name}');

                $("div.actionItem").hover(function(){$("div.itemEditLink", this).toggle()})
                $("div.discussionItem").hover(function(){$("div.itemEditLink", this).toggle()});
                $("div.discussionItem").hover(function(){$("div.actionItemLink", this).toggle()});

                $("#newPollButton").hide();
                $("#newDiscussionItemButton").attr('disabled', 'disabled');
                $("textarea#content").keyup(function(){
                    disableSubmitButtonsIfNoContent();
                });
            });

            function RetroController($scope) {
                $scope.retroItems = ${(retro.retroItems as JSON).toString()};

                $scope.addDiscussionItem = function(discussionItem) {
                    $scope.retroItems.push(discussionItem);
                    $scope.$apply();
                    $('#content').val("").focus();
                    $("#newDiscussionItemButton").attr('disabled', 'disabled');
                }
            }

            function appendDiscussionItem(discussionItem) {
                angular.element($('#retroItemList')).scope().addDiscussionItem(discussionItem);
            }

            function appendAndPublishDiscussionItem(discussionItem) {
                appendDiscussionItem(discussionItem);
                publish(thisRetroTopic(), {type: 'appendDiscussionItem', item: discussionItem});
            }

            function editRetroName() {
                $("#retroNameField").val($("#retroName").text());
                $("#retroName").hide();
                $("#retroNameEdit").hide();
                $("#retroNameField").show().focus().select();
            }

            function enterRetroName() {
                var newRetroName = $("#retroNameField").val().trim();
                if (newRetroName !== '') {
                    $("#retroName").text(newRetroName);
                    changeRetroName(newRetroName);
                }
                escapeRetroName();
            }

            function escapeRetroName() {
                $("#retroNameField").hide();
                $("#retroName").show();
                $("#retroNameEdit").show();
            }

            function changeRetroName(retroName) {
                $.post("${createLink(controller: 'retrospective', action: 'setName')}", {'name': retroName, 'id': $('#retroId').val()});
                publish(thisRetroTopic(), {type: 'changeRetroName', item: retroName});
            }
        </script>
    </head>
    <body>
        <div class="sidebar">
            <g:link controller="project" action="show">Projects</g:link>
            <br/><br/>
            <g:link controller="retrospective" action="show" params="[project: retro.project.id]">Current Retro</g:link>
            <br/><br/>
            <g:each in="${previousRetros}" var="previousRetro">
                <div style="margin-bottom: 10px; background-color: #ffffff; border-radius: 8px; padding: 4px">
                    <g:link controller="retrospective" action="show" params="[project: previousRetro.project.id, id: previousRetro.id]">${previousRetro.name}</g:link>
                </div>
            </g:each>
        </div>

        <div class="retrospective" id="retro">
            <div class="retroHeader">

                <span id="retroName"></span>
                <g:if test="${retro.isActive}">
                    <g:textField name="retroNameField" id="retroNameField" style="display:none" />
                    <a id="retroNameEdit" href="#" onclick="editRetroName()" style="font-size: 9pt;">edit</a>
                </g:if>

                <span style="float: right">
                    <g:form url="[controller: 'retrospective', action: 'close']" name="close">
                        <g:hiddenField name="retroId" value="${retro.id}"/>
                        <g:hiddenField name="project" value="${retro.project.id}"/>
                        <g:submitButton name="Retrospective" value="Close Retro"/>
                    </g:form>
                </span>
            </div>
            <div class="retroDetails">
                Project: ${retro.project.name}
            </div>
            <hr style="border: 1px solid #808080">
            <div class="columnContainer">
            <div class="retroItemColumn">
                <div class="columnHeader">
                    Discussion Items
                </div>
                <div id="retroItemList" ng-controller="RetroController">
                    <div class="discussionItemWrapper" style="overflow: hidden" ng-repeat="retroItem in retroItems">
                        <div class="discussionItemNumber">
                            {{retroItem.number}}
                        </div>
                        <div ng-if="retroItem.class === 'retrobot.DiscussionItem'" class="discussionItem discussionItemType{{retroItem.classification}}">
                            {{retroItem.content}}
                            <div class="itemEditLink" style="float: right" hidden="hidden">
                                <a href="${createLink(controller: 'discussionItem', action: 'edit')}/{{retroItem.id}}">
                                    <g:img dir="images" file="Wrench.png" width="16" height="16"/>
                                </a>
                            </div>
                            <div class="actionItemLink" style="float: right; padding-right: 5px" hidden="hidden">
                                <a href="${createLink(controller: 'actionItem', action: 'create')}?discussionId={{retroItem.id}}">
                                    <g:img dir="images" file="Add.png" width="16" height="16"/>
                                </a>
                            </div>
                        </div>
                        <div ng-if="retroItem.class === 'retrobot.Poll'" class="discussionItem" style="padding-left: 40px;">
                            {{retroItem.content}}
                            <br/>
                            <div id="poll_{{retroItem.number}}">
                                <div ng-repeat="pollItem in retroItem.pollItems">
                                    <label>
                                        <g:radio name="poll_{{retroItem.number}}" value="radio_{{pollItem.id}}" />
                                        {{pollItem.content}}
                                    </label>
                                    <br/>
                                </div>
                            </div>
                            <br/>
                            <button>Vote</button>
                        </div>
                    </div>
                </div>

                <g:if test="${retro.isActive}">
                    <div class="discussionItem">
                        <g:formRemote url="[controller: 'discussionItem', action: 'create']" name="add">
                            <g:textArea name="newRetroItemText" id="content" rows="5" cols="50" maxlength="255" width="100%" autofocus="autofocus"/>
                            <g:hiddenField name="retroId" value="${retro.id}"/>
                            <!-- pollEditor goes here -->

                            <div>
                                <g:submitToRemote name="DiscussionItem" id="newDiscussionItemButton"
                                                  value="Add Discussion Item" onSuccess="appendAndPublishDiscussionItem(data)"
                                                  action="createWithJson" controller="discussionItem"/>

                                <g:select name="classification" id="classification" optionKey="id" optionValue="value"
                                      from="${Retrospective.DiscussionItemClassifications}"/>
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
