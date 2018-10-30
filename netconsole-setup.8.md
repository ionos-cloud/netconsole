---
date: 2018-10-30
footer: netconsole-setup
header: "netconsole-setup's Manual"
layout: page
license: 'Licensed under the ISC license'
section: 8
title: NETCONSOLE-SETUP
---

# NAME

netconsole-setup - Dynamically configure Linux netconsole

# SYNOPSIS

**netconsole-setup** [[**+**][**target-port**]@]**target-host** ...

# DESCRIPTION

Netconsole is a Linux kernel module that sends all kernel log messages over
the network to another computer. It was designed to be as instantaneous as
possible, to enable the logging of even the most critical kernel bugs. It
works from IRQ contexts as well, and does not enable interrupts while sending
packets. Due to these unique needs, only IP networks, UDP packets and Ethernet
devices are supported.

**netconsole-setup** eases the configuration of the netconsole by just taking
the target hostname or IP address. It determines all the needed configuration
values from the running network device (like network interface, target IP and
MAC address). Multiple target hosts can be specified. Each host can be prefixed
with a target port and a plus sign to enable extended console support.

# OPTIONS

**+**
:    if present, enable extended console support for this host

**target-port**
:    port for logging agent (kernel default is port 6666)

**target-host**
:    hostname or IP address for logging agent

# EXAMPLES

```
netconsole-setup loghost
```

sends all kernel log messages to host *loghost*.

```
netconsole-setup +4444@loghost
```

sends all kernel log messages to host *loghost* on port *4444* using the
extended console support.

```
netconsole-setup loghost1 4444@loghost2
```

sends all kernel log messages to host *loghost1* on the default port and to
host *loghost2* on port *4444*.

# AUTHOR

Benjamin Drung <benjamin.drung@cloud.ionos.com>
