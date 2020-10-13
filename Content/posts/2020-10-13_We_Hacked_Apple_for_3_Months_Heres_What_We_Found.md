---
date: 2020-10-13 20:59
description: Sam Curry, Brett Buerhaus, Ben Sadeghipour, Samuel Erb, and Tanner Barnes hack into Apple's infrastructure and find some serious issues
tags: link, apple, hack
title: We Hacked Apple for 3 Months: Here’s What We Found
detailsTitle: [We Hacked Apple for 3 Months: Here’s What We Found](https://samcurry.net/hacking-apple/)
---

A terrific read!

> Some of the immediate findings from the automated scanning were:

<blockquote><ul>
 <li> VPN servers affected by Cisco CVE-2020-3452 Local File Read 1day (x22)</li>
 <li> Leaked Spotify access token within an error message on a broken page</li>
</ul></blockquote>

Ouch

> When you submitted an application to use the forum, you supplied nearly all of the values of your account as if you were registering to the Jive forum normally. This would allow the Jive forum to know who you were based on your IDMSA cookie since it tied your email address belonging to your Apple account to the forum.

> One of the values that was hidden on the page within the application to register to use the forum was a “password” field with the value “###INvALID#%!3”.

> If anyone had applied using this system and there existed functionality where you could manually authenticate, you could simply login to their account using the default password and completely bypass the "Sign In With Apple" login.

> After about two minutes we received a 302 response indicating a successful login to a user with a 3 character username using the default password we found earlier

Ouch!
