resource testdata2 {
protocol C;
  on node1 {
    device /dev/drbd1;
    disk /dev/sdc;
    address 172.16.2.61:7789;
    meta-disk internal;
  }
  on node2 {
    device /dev/drbd1;
    disk /dev/sdc;
    address 172.16.2.62:7789;
    meta-disk internal;
  }
}
