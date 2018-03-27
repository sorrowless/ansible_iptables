#!/bin/sh

IPTABLES=/sbin/iptables

{% if iptables.flush_all %}
# Clean all
$IPTABLES -F
$IPTABLES -X
$IPTABLES -t nat -F
$IPTABLES -t nat -X
$IPTABLES -t mangle -F
$IPTABLES -t mangle -X
{% endif %}

# Accept all from localhost
$IPTABLES -A INPUT -i lo -j ACCEPT

# Allow established connections:
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Accept ICMP packets (it allows ping for example)
{% if iptables.icmp_allowed %}
$IPTABLES -A INPUT -p icmp -j ACCEPT
{% endif %}

# Allow NTP traffic for time synchronization.
{% if iptables.ntp_allowed %}
$IPTABLES -A OUTPUT -p udp --dport 123 -j ACCEPT
$IPTABLES -A INPUT -p udp --sport 123 -j ACCEPT
{% endif %}

# Allowed ports.
{% for port in iptables.default_allowed_tcp_ports %}
$IPTABLES -A INPUT -p tcp -m tcp --dport {{port}} -j ACCEPT
{% endfor %}
{% for port in iptables.group_allowed_tcp_ports %}
$IPTABLES -A INPUT -p tcp -m tcp --dport {{port}} -j ACCEPT
{% endfor %}
{% for port in iptables.host_allowed_tcp_ports %}
$IPTABLES -A INPUT -p tcp -m tcp --dport {{port}} -j ACCEPT
{% endfor %}
{% for port in iptables.default_allowed_udp_ports %}
$IPTABLES -A INPUT -p udp -m udp --dport {{port}} -j ACCEPT
{% endfor %}
{% for port in iptables.group_allowed_udp_ports %}
$IPTABLES -A INPUT -p udp -m udp --dport {{port}} -j ACCEPT
{% endfor %}
{% for port in iptables.host_allowed_udp_ports %}
$IPTABLES -A INPUT -p udp -m udp --dport {{port}} -j ACCEPT
{% endfor %}

# Raw rules
{% for rule in iptables.raw_rules %}
$IPTABLES {{rule}}
{% endfor %}

# Drop all other
{% if iptables.deny_all_unallowed %}
$IPTABLES -t filter --policy INPUT DROP
{% endif %}
