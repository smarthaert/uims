cidprofit
select `sm`.`custtel` AS `custtel`,sum(`sm`.`shishou`) AS `profit` from `selllogmains` `sm` group by `sm`.`custtel`

delivertypes
select if((`selllogdetails`.`additional` = '-'),'正常',`selllogdetails`.`additional`) AS `additional`,sum(`selllogdetails`.`amount`) AS `amount` from `selllogdetails` group by `selllogdetails`.`additional`

orderinshorts
select `om`.`custname` AS `custname`,`om`.`custtel` AS `custtel`,`od`.`pid` AS `pid`,(`od`.`amount` - `od`.`ramount`) AS `amount`,`om`.`oid` AS `oid`,`om`.`cdate` AS `cdate`,`s`.`amount` AS `stockamount` from ((`ordermains` `om` join `orderdetails` `od`) join `stocks` `s`) where ((`om`.`status` = '1') and (`om`.`oid` = `od`.`oid`) and (`od`.`amount` > `od`.`ramount`) and (`s`.`pid` = `od`.`pid`) and (`s`.`amount` > (`od`.`amount` - `od`.`ramount`))) order by `om`.`custid`

orderstates
select `ordermains`.`dtype` AS `type`,`ordermains`.`payment` AS `payment`,sum(1) AS `amount`,sum(`ordermains`.`shishou`) AS `value` from `ordermains` group by `ordermains`.`dtype`,`ordermains`.`payment` order by `ordermains`.`dtype`,`ordermains`.`payment`

pidprofit
select `selllogdetails`.`pid` AS `pid`,sum(`selllogdetails`.`amount`) AS `amount`,sum(`selllogdetails`.`subtotal`) AS `profit` from `selllogdetails` where (`selllogdetails`.`additional` = '-') group by `selllogdetails`.`pid` order by `selllogdetails`.`pid`

productionpreferences
select `sm`.`custstate` AS `custstate`,`sd`.`pid` AS `pid`,`sd`.`pid` AS `goodsname`,`sd`.`color` AS `color`,sum(`sd`.`amount`) AS `amount` from (`selllogmains` `sm` join `selllogdetails` `sd`) where ((`sd`.`additional` = '-') and (`sm`.`status` = '1') and (`sm`.`slid` = `sd`.`slid`)) group by `sm`.`custstate`,`sd`.`pid`,`sd`.`color` order by `sm`.`custstate`,sum(`sd`.`amount`) desc,`sd`.`pid`,`sd`.`color`

profitareas
select `sm`.`custstate` AS `custstate`,sum(`sm`.`shishou`) AS `profit` from `selllogmains` `sm` group by `sm`.`custstate`

profitcustomers
select `c`.`cname` AS `cname`,`c`.`tel` AS `tel`,`t`.`profit` AS `profit` from (`customers` `c` join `cidprofit` `t` on((`t`.`custtel` = `c`.`tel`))) order by `t`.`profit`

profitproductions
select `s`.`pid` AS `pid`,`s`.`goodsname` AS `goodsname`,`s`.`color` AS `color`,`pp`.`profit` AS `profit` from (`stocks` `s` join `pidprofit` `pp` on((`pp`.`pid` = `s`.`pid`))) order by `s`.`pid`

profitshippers
select `s`.`sname` AS `sname`,`s`.`tel` AS `tel`,`sp`.`amount` AS `amount`,`sp`.`volume` AS `volume`,`sp`.`profit` AS `profit` from (`shippers` `s` join `sidprofit` `sp` on((`s`.`tel` = `sp`.`stel`))) order by `s`.`sid`

sellcostcustomers
select `c`.`cname` AS `cname`,`c`.`tel` AS `tel`,if((`ad`.`dtype` = '-'),'正常',`ad`.`dtype`) AS `type`,sum(`ad`.`ramount`) AS `amount` from ((`aftersellmains` `am` join `afterselldetails` `ad`) join `customers` `c`) where ((`c`.`tel` = `am`.`custtel`) and (`am`.`tid` = `ad`.`tid`) and (`am`.`status` = '1')) group by `c`.`cname`,`c`.`tel`,`ad`.`dtype` order by `c`.`cname`,`c`.`tel`,sum(`ad`.`ramount`) desc,`ad`.`dtype`

sellcostgifts
select `selllogdetails`.`additional` AS `additional`,sum(`selllogdetails`.`inprice`) AS `cost` from `selllogdetails` where (`selllogdetails`.`additional` = '赠品') group by `selllogdetails`.`additional`

sellcostproductions
select `s`.`pid` AS `pid`,`s`.`color` AS `color`,if((`ad`.`dtype` = '-'),'正常',`ad`.`dtype`) AS `type`,sum(`ad`.`ramount`) AS `amount`,`s`.`unit` AS `unit` from ((`aftersellmains` `am` join `afterselldetails` `ad`) join `stocks` `s`) where ((`s`.`pid` = `ad`.`pid`) and (`am`.`tid` = `ad`.`tid`) and (`am`.`status` = '1')) group by `s`.`pid`,`s`.`color`,`ad`.`dtype` order by `s`.`pid`,`s`.`color`,sum(`ad`.`ramount`) desc,`ad`.`dtype`

sidprofit
select `selllogmains`.`stel` AS `stel`,sum(`selllogmains`.`shishou`) AS `profit`,sum(`selllogmains`.`aamount`) AS `amount`,sum(`selllogmains`.`avolume`) AS `volume` from `selllogmains` where (`selllogmains`.`status` = '1') group by `selllogmains`.`stel`

statementdays
select date_format(`contactpayments`.`cdate`,'%Y-%m-%d') AS `date`,`contactpayments`.`method` AS `method`,sum(`contactpayments`.`outmoney`) AS `outmoney`,sum(`contactpayments`.`inmoney`) AS `inmoney`,sum(`contactpayments`.`strike`) AS `strike` from `contactpayments` group by `contactpayments`.`method`,date_format(`contactpayments`.`cdate`,'%Y-%m-%d') order by date_format(`contactpayments`.`cdate`,'%Y-%m-%d') desc

stocknews
select `stocks`.`pid` AS `pid`,`stocks`.`goodsname` AS `goodsname`,`stocks`.`color` AS `color`,`stocks`.`amount` AS `amount`,`stocks`.`unit` AS `unit`,`stocks`.`volume` AS `volume` from `stocks` order by `stocks`.`pid`

stockrepairs
select `afterselldetails`.`pid` AS `pid`,`afterselldetails`.`goodsname` AS `goodsname`,`afterselldetails`.`color` AS `color`,sum(`afterselldetails`.`ramount`) AS `amount`,`afterselldetails`.`unit` AS `unit`,`afterselldetails`.`volume` AS `volume` from `afterselldetails` where (`afterselldetails`.`dtype` = '维修') group by `afterselldetails`.`pid` order by `afterselldetails`.`pid`

stocktips
select `stocks`.`pid` AS `pid`,`stocks`.`goodsname` AS `goodsname`,`stocks`.`color` AS `color`,`stocks`.`amount` AS `amount`,`stocks`.`unit` AS `unit`,`stocks`.`baseline` AS `baseline` from `stocks` where (`stocks`.`amount` < `stocks`.`baseline`) order by `stocks`.`updated_at` desc,`stocks`.`amount`

