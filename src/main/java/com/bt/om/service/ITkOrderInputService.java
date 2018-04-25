package com.bt.om.service;


import com.bt.om.entity.TkOrderInput;

public interface ITkOrderInputService {     
    public TkOrderInput selectByOrderId(String orderId);
}
