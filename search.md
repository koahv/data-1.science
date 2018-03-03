---
layout: page
title: Search
permalink: /search/
---
<!-- Html Elements for Search -->
<div id="search-container">
<input type="text" id="search-input" placeholder="search... (250 results max)">
<p><ul id="results-container"></ul></p>
</div>

<!-- Script pointing to search-script.js -->
<script src="/simple-jekyll-search.min.js" type="text/javascript"></script>

<!-- Configuration -->
<script>
SimpleJekyllSearch({
  searchInput: document.getElementById('search-input'),
  resultsContainer: document.getElementById('results-container'),
  json: '/search.json'
})
</script>
