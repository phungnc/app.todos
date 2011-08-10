<<<<<<< HEAD
<div id="todoapp">

  <div class="title" style="text-align: center; margin-bottom: 30px; position: relative;">
    <h1 style="display: inline;">Todos</h1>
    <div id="storage-mode"></div>
    <span id="play" style=" position: absolute; top: 20px; right: 0;"><a href="#" onclick="play(); return false;"><img src="img/play.png"></img></a></span>
=======
<header id="title">
  <h1>Todos</h1>
</header>
<div id="wrapper" class="hbox flex">
  <div id="sidebar" class="vbox">
    <div class="vbox flex">
      <div id="todo-controls" class="vbox flex">
        <span id="button-storage"></span>
        <span id="button-checkall"></span>
        <span id="button-uncheckall"></span>
        <span id="button-unsaved"></span>
        <span id="button-refresh"></span>
      </div>
      <div class="hbox">
        <footer class="vbox flex">
          <button id="refresh-db" style="font-size: 0.8em; width: 100%" onclick="window.location.href=base_url+'mysql/restore'">Rebuild Database</button>
        </footer>
      </div>
    </div>
>>>>>>> dev
  </div>
  <div class="vdivide"></div>
  <div id="main" class="vbox flex">
    <div id="tasks" class="vbox flex">
      <div id="create-todo" class="hbox">
        <div class="new-todo hbox flex" id="new-todo">
          <input type="text" placeholder="What needs to be done?">
          <span class="ui-tooltip-top" style="display:none;">Press Enter to save this task</span>
          <div id="todo-stats" class="count flex tright"><span class="countVal"></span></div>
        </div>
      </div>

      <div id="todo-list" class="items vbox flex autoflow"></div>

<<<<<<< HEAD
    <div id="create-todo">
      <input id="new-todo" placeholder="What needs to be done?" type="text" />
      <span class="ui-tooltip-top" style="display:none;">Press Enter to save this task</span>
    </div>
    <div>
      <fieldset style="padding-bottom: 10px;">
        <legend class="showhide-controls" style="cursor: pointer"><span class="ui-icon ui-icon-triangle"></span><span class="legend" id="main-box">Show/Hide Options</span></legend>
        <div id="todo-controls" class="showhide" style="display: none;">
          <fieldset>
            <legend class="showhide-controls" style="cursor: pointer"><span class="ui-icon ui-icon-triangle"></span><span class="legend" id="storage-box">Storage Mode</span></legend>
            <div class="showhide" style="">
              <span id="button-storage"></span>
            </div>
          </fieldset>
          <fieldset>
            <legend class="showhide-controls" style="cursor: pointer"><span class="ui-icon ui-icon-triangle"></span><span class="legend" id="client-box">Client only settings</span></legend>
            <div class="showhide" style="">
              <span id="button-checkall"></span>
              <span id="button-uncheckall"></span>
            </div>
          </fieldset>
          <fieldset>
            <legend class="showhide-controls" style="cursor: pointer"><span class="ui-icon ui-icon-triangle"></span><span class="legend" id="sync-box">Synchronize</span></legend>
            <div class="showhide" style="">
              <span id="button-unsaved"></span>
              <span id="button-refresh"></span>
            </div>
          </fieldset>
=======
      <footer class="hbox">
        <div id="storage-mode"><span>aslkjdlaksdjlaksdjalskd</span></div>
        <div class="flex">
          <button class="clear">Clear completed</button>
>>>>>>> dev
        </div>
      </footer>
    </div>
  </div>

</div>


<!-- Templates -->

<script type="text/template" id="item-template">
  <div class="item <%= done ? 'done' : '' %>">
    <div class="display">
      <input class="check" type="checkbox" <%= done ? 'checked="checked"' : '' %> />
        <span class="todo-content"></span><a class="destroy"></a>
    </div>
    <div class="edit">
      <input class="todo-input" type="text" value="" />
    </div>
  </div>
</script>

<script type="text/template" id="stats-template">
  <% if (total) { %>
  <span class="todo-count">
    <span class="number"><%= remaining %></span>
    <span class="word"><%= remaining == 1 ? 'item' : 'items' %></span> left
  </span>
  <% } %>
</script>

<script type="text/template" id="button-checkall-template">
  <button title="Check all Todos" class="primary_lg <%=remaining==0 ? 'disabled' : '' %>" type="button" <%=remaining==0 ? 'disabled' : '' %>><%=value%></button>
</script>

<script type="text/template" id="button-uncheckall-template">
  <button title="Uncheck all Todos" class="primary_lg <%=done==0 ? 'disabled' : '' %>" type="button" <%=done==0 ? 'disabled' : '' %>><%=value%></button>
</script>

<script type="text/template" id="button-unsaved-template">
  <button title="Save all local changes" class="primary_lg <%=unsaved==0 ? 'disabled' : 'alert' %>" type="button" <%=unsaved==0 ? 'disabled' : '' %>><%=value%></button>
</script>

<script type="text/template" id="button-refresh-template">
  <button title="Reloads a fresh set from server" class="primary_lg <%=busy ? 'disabled' : '' %>" type="button" <%=busy ? 'disabled' : '' %>><%=value%></button>
</script>

<script type="text/template" id="button-storage-template">
  <button title="Toggle Storage" class="primary_lg" type="button" style=""><%=value%></button>
</script>

<script type="text/template" id="storage-status-template">
  <span><%=value%></span>
</script>

<script type="text/template" id="dialog-template">
  <div class="demo">
    <div id="dialog-modal" title="<%=title%>">
      <p><%=content%></p>
    </div>
  </div>
</script>
