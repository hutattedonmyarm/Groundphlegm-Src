---
date: 2020-07-14 18:29
description: Facebook broke a crapton of apps. Again.
tags: link, social media
title: Facebook’s iOS SDK caused another slew of app crashes
detailsTitle: [Facebook’s iOS SDK caused another slew of app crashes](http://web.archive.org/web/20200714081114/https://developers.facebook.com/blog/post/2020/07/13/bug-now-resolved-fb-ios-sdk-outage-causing-disruption-third-party-ios-apps/)
---

I’m linking to the archive version, because I don’t want to link to Facebook directly since I despise that company.

> Last week we made a server-side code change that triggered crashes for some iOS apps using the Facebook SDK.

This has happened [in May this year](http://web.archive.org/web/20200714081114/https://developers.facebook.com/status/issues/551281292461657/) already.

They updated some server-side code, causing some versions of the SDK to crash the app during the app launch. The worst part about it is, that you didn’t even need to load or call any functions in the SDK, because it uses all sorts of shenanigans to ensure its launch together with the  app. Merely including the files was enough.

On one hand, I hope this will cause more and more developers to stop using it and reduce their dependency on other code. The SDK has a plethora of privacy issues too, some can be turned off (but are enabled by default!). On the other hand, Facebook *requires* you to use their SDK if you want to provide a social “Login with Facebook” button and it’s pretty difficult to tell your customers that they need to either connect their account with another social login or with a regular email/password combination and a slow process to phase that out.