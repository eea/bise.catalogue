<div class="facet-header closed">
  <div class="triangle"></div>
  <legend><%= this.titleFor(title) %></legend>
</div>

<% if (typeof(terms) != 'undefined' ){ %>
  <ul>
      <% _.each(terms, function(t) { %>
        <% if (t.term != ''){ %>
          <li class="facet-item">
            <% if (Catalogue.isFacetSelected(title, t.term )){ %>
              <a class="facet-remove" data-facet="<%= title %>" data-value="<%= t.term %>">
                Remove
              </a>
            <% } else { %>
              <span class="facet-count">
                <%= t.count %>
              </span>
            <% } %>
            <a class="facet-link" data-facet="<%= title %>" data-value="<%= t.term %>">
              <%= t.term %>
            </a>
          </li>
        <% } %>
      <% }) %>
      <% if (terms.length > 5){ %>
        <li class="show-more">
          <a>
            -- Show/Hide more... --
          </a>
        </li>
      <% } %>
  </ul>
<% } else { %>
  <ul>
    <% _.each(entries, function(e) { %>
      <li class="facet-item">
        <% d = new Date(e.time) %>
        <% if (Catalogue.isFacetSelected(title, d.getFullYear() )){ %>
          <a class="facet-remove" data-facet="<%= title %>" data-value="<%= d.getFullYear() %>">
            Remove
          </a>
        <% } else { %>
          <span class="facet-count">
            <%= e.count %>
          </span>
        <% } %>
        <a class="facet-link" data-facet="<%= title %>" data-value="<%= d.getFullYear() %>"><%= d.getFullYear() %></a>
      </li>
    <% }) %>
    <% if (entries.length > 5){ %>
      <li class="show-more">
        <a>
          -- Show/Hide more... --
        </a>
      </li>
    <% } %>
  </ul>
<% } %>
