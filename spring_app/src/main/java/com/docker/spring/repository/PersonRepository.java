package com.docker.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.docker.spring.model.Persons;

@Repository
public interface PersonRepository extends JpaRepository<Persons, Integer> {

}