package com.KoreaIT.sdy.demo.controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.KoreaIT.sdy.demo.dto.FileUploadRequestDto;
import com.KoreaIT.sdy.demo.service.S3FileService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/s3")
@Slf4j
public class FileController {

    @Autowired
    private S3FileService fileService;

    @PostMapping("/file")
    public String uploadFile(@RequestParam("file") MultipartFile file, @RequestParam("roomId")String roomId){
        FileUploadRequestDto reqDto = FileUploadRequestDto.builder()
                .file(file)
                .transaction(UUID.randomUUID().toString())
                .chatRoom(roomId)
                .build();

        log.info("넘어온 데이터 {}", reqDto);
        String s3DataUrl = fileService.uploadFile(reqDto).getS3DataUrl();
        log.info("fileUpload {}", s3DataUrl);

        return s3DataUrl;
    }
}