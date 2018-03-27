sbog/iptables
=============

Role to install and configure iptables

#### Requirements

Ansible 2.4

#### Role Variables

```yaml
iptables:
  # Enable whole role
  enabled: yes
  # Flush all rules before adding role ones
  flush_all: yes
  # Allow NTP
  ntp_allowed: yes
  # List of allowed TCP ports
  allowed_tcp_ports: [22, 80, 443]
  # List of allowed UDP ports
  allowed_udp_ports: []
  # Any raw rules can be added
  raw_rules: []
  # Deny all which were not explicitly allowed
  deny_all_unallowed: yes
  # Allow ICMP
  icmp_allowed: yes
```

#### Dependencies

None

#### Example Playbook

```yaml
- name: Run and configure Iptables
  hosts: all
  remote_user: root

  roles:
    - iptables
```

#### License

Apache 2.0

#### Author Information

Stanislaw Bogatkin (https://sbog.ru)
