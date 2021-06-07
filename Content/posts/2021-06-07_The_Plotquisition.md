---
date: 2021-06-07 17:53
description:
tags: link, project, gaming, podcasts
title: The Plotquisition
detailsTitle: [The Plotquisition](https://hutattedonmyarm.github.io/Plotquisition/)
---

I made a thing! As teased, a new post about one of the things I had in mind I wanted to talk about.

[The Plotquisition](https://hutattedonmyarm.github.io/Plotquisition/) is an episode viewer for the gaming podcast [The Podqusition](https://soundcloud.com/jimquisition). The hosts talk about the games they mentioned and have recently*-ish* started adding the name of the games they mention in the show notes, even including timestamps. Oh, and they do so in the same format every time, perfect for automated parsing!

My main motivation was that it's not exactly easy to find out which episodes mentioned a specific game. Sure, you could go to their Soundcloud and look at every episode's description, but that takes up so much time!

The Plotquisition essentially parses every episode and lists the games and their timestamps. They even link to the specific time!

From a technical standpoint it's pretty simple. It's a python script which loads the RSS feed from Soundcloud, parses the description of the episodes (excluding his other Podcasts such as Boston's Favorite Son) to extract the games list, correct episode cover image, etc.
It then builds the HTML (not even a template and replace, just building it up) and writes it to the index.html

This makes it super convenient to be hosted by Github pages. It's just a Github action which runs via cron a couple times on Thursdays (the day a new episode drops) which runs the script, sets the date created for the badge and commits the new index.html.

If you're curious [check out the source code](https://github.com/hutattedonmyarm/Plotquisition/).