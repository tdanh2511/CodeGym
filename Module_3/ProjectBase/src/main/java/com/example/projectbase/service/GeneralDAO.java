package com.example.projectbase.service;

import java.util.List;

public interface GeneralDAO <T> {
    List<T> findAll();
}
