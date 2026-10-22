---
layout: default
title: Home
---
<section class="post-list">
  <h2>Projects</h2>
  {% for p in site.data.projects %}
  <article class="card">
    <p class="meta">
      {% if p.language != "" %}<span class="tag">{{ p.language }}</span> {% endif %}
      Updated {{ p.updated }}
    </p>
    <h3><a href="{{ p.url }}">{{ p.name }}</a></h3>
    {% if p.description != "" %}<p>{{ p.description }}</p>{% endif %}
    {% if p.page != "" %}<p class="links"><a href="{{ p.page }}">Project page</a></p>{% endif %}
  </article>
  {% else %}
  <p>No projects yet.</p>
  {% endfor %}

  <h2>Blog</h2>
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
