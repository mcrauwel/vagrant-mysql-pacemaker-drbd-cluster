resource testdata1 {
protocol C;
  on node1 {
    device /dev/drbd0;
    disk /dev/sdb;
    address 172.16.2.61:7788;
    meta-disk internal;
  }
  on node2 {
    device /dev/drbd0;
    disk /dev/sdb;
    address 172.16.2.62:7788;
    meta-disk internal;
  }
}
