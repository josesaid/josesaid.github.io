---
layout: default
title: Home
---
<section class="post-list">
  <h2>Projects</h2>
  {% for post in site.posts %}
  <article class="card">
    <p class="meta">
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
      {% for tag in post.tags %}<span class="tag">{{ tag }}</span> {% endfor %}
    </p>
    <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
    <p>{{ post.description }}</p>
  </article>
  {% endfor %}
</section>
