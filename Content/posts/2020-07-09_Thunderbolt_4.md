---
date: 2020-07-09 08:11
description: Thunderbolt 4 details are out. No extra bandwidth, but a few other goodies
tags: link, hardware
title: Intel reveals Thunderbolt 4
detailsTitle: [Intel reveals Thunderbolt 4](https://newsroom.intel.com/news/introducing-thunderbolt-4-universal-cable-connectivity-everyone/)
---

The minimum speed requirements is unsurprisingly still at 40 Gb/s, which is still a lot, instead they raised some of the other bars:

<blockquote>
<ul>
<li> Double the minimum video and data requirements of Thunderbolt 3.<ul>
  <li> Video: Support for two 4K displays or one 8K display.
  <li> Data: PCIe at 32 Gbps for storage speeds up to 3,000 MBps.</ul>
<li> Support for docks with up to four Thunderbolt 4 ports.
<li> PC charging on at least one computer port.
<li> Wake your computer from sleep by touching the keyboard or mouse when connected to a Thunderbolt dock.
<li> Required Intel VT-d-based direct memory access (DMA) protection that helps prevent physical DMA attacks. (Read more in the Thunderbolt Security Brief.)
</ul>
</blockquote>

There’s a comparison image in the article which I won’t include, because it sounds *very* marketing-y.

TB4 cables can now be 2m in length and enjoy the full bandwidth of 40 Gb/s, plus we can now get docks with up to *4* TB ports!

It also requires DMA (Direct Memory Access) protection, which on one hand is a good thing (there were a few attacks using TB3 and DMA in the past), but that sadly also lowers adoption rate and makes it more difficult to adopt (and costly too, because you’ll likely need either an Intel CPU or an extra chip for that)

Hey, I can’t wait for *even more* confusion around USB and Thunderbolt. Confusion around USB has been up a lot since they started renaming their old standards every time a new one came out (looking at you USB 3.1 and 3.2), shot up with USB-C (that’s only the connector and has not much to do with the underlying USB version number) where it started to get really tough to tell which cable and thing is supporting which USB-C feature and how compliant it is. *Then* it got bad, because TB3 and USB-C share the same connector. Now to add to the confusion we have TB4.

Enough about that though. Intel is planning to ship corresponding chips later this year. Apple has been pretty quiet about Thunderbolt in their ARM Macs, so we’ll see if they include TB ports, which version, and which USB version they’re going with