[root@node1 ~]# pcs status
```
Cluster name: mycluster
Stack: corosync
Current DC: node1 (version 1.1.16-12.el7_4.5-94ff4df) - partition with quorum
Last updated: Fri Dec  8 10:47:15 2017
Last change: Fri Dec  8 10:32:45 2017 by root via cibadmin on node1

2 nodes configured
5 resources configured

Online: [ node1 node2 ]

Full list of resources:

 Master/Slave Set: DrbdDataClone [DrbdData]
     Masters: [ node1 ]
     Slaves: [ node2 ]
 VirtIP	(ocf::heartbeat:IPaddr2):	Started node1
 MySQL	(systemd:mysqld):	Started node1
 DrbdFS	(ocf::heartbeat:Filesystem):	Started node1

Daemon Status:
  corosync: active/enabled
  pacemaker: active/enabled
  pcsd: active/enabled
```

[root@node1 ~]# pcs cluster stop node1
```
node1: Stopping Cluster (pacemaker)...
node1: Stopping Cluster (corosync)...
```
[root@node1 ~]# pcs status
```
Error: cluster is not currently running on this node
```
[root@node1 ~]# mysql -h virtip
```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.20 MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SELECT @@hostname;
+------------+
| @@hostname |
+------------+
| node2      |
+------------+
1 row in set (0.00 sec)

mysql> ^DBye
```
[root@node1 ~]# pcs cluster start node1
```
node1: Starting Cluster...
```
[root@node1 ~]# pcs status
```
Cluster name: mycluster
Stack: corosync
Current DC: node2 (version 1.1.16-12.el7_4.5-94ff4df) - partition with quorum
Last updated: Fri Dec  8 10:47:59 2017
Last change: Fri Dec  8 10:32:45 2017 by root via cibadmin on node1

2 nodes configured
5 resources configured

Online: [ node1 node2 ]

Full list of resources:

 Master/Slave Set: DrbdDataClone [DrbdData]
     Masters: [ node2 ]
     Slaves: [ node1 ]
 VirtIP	(ocf::heartbeat:IPaddr2):	Started node2
 MySQL	(systemd:mysqld):	Started node2
 DrbdFS	(ocf::heartbeat:Filesystem):	Started node2

Daemon Status:
  corosync: active/enabled
  pacemaker: active/enabled
  pcsd: active/enabled
```
[root@node1 ~]# pcs cluster stop node2
```
node2: Stopping Cluster (pacemaker)...
node2: Stopping Cluster (corosync)...
```
[root@node1 ~]# pcs status
```
Cluster name: mycluster
Stack: corosync
Current DC: node1 (version 1.1.16-12.el7_4.5-94ff4df) - partition with quorum
Last updated: Fri Dec  8 10:48:18 2017
Last change: Fri Dec  8 10:32:45 2017 by root via cibadmin on node1

2 nodes configured
5 resources configured

Online: [ node1 ]
OFFLINE: [ node2 ]

Full list of resources:

 Master/Slave Set: DrbdDataClone [DrbdData]
     Masters: [ node1 ]
     Stopped: [ node2 ]
 VirtIP	(ocf::heartbeat:IPaddr2):	Started node1
 MySQL	(systemd:mysqld):	Started node1
 DrbdFS	(ocf::heartbeat:Filesystem):	Started node1

Daemon Status:
  corosync: active/enabled
  pacemaker: active/enabled
  pcsd: active/enabled
```
[root@node1 ~]# mysql -h virtip
```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.20 MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SELECT @@hostname;
+------------+
| @@hostname |
+------------+
| node1      |
+------------+
1 row in set (0.00 sec)

mysql> ^DBye
```
[root@node1 ~]# pcs cluster start node2
```
node2: Starting Cluster...
```
[root@node1 ~]# pcs status
```
Cluster name: mycluster
Stack: corosync
Current DC: node1 (version 1.1.16-12.el7_4.5-94ff4df) - partition with quorum
Last updated: Fri Dec  8 10:49:07 2017
Last change: Fri Dec  8 10:32:45 2017 by root via cibadmin on node1

2 nodes configured
5 resources configured

Online: [ node1 node2 ]

Full list of resources:

 Master/Slave Set: DrbdDataClone [DrbdData]
     Masters: [ node1 ]
     Slaves: [ node2 ]
 VirtIP	(ocf::heartbeat:IPaddr2):	Started node1
 MySQL	(systemd:mysqld):	Started node1
 DrbdFS	(ocf::heartbeat:Filesystem):	Started node1

Daemon Status:
  corosync: active/enabled
  pacemaker: active/enabled
  pcsd: active/enabled
```
