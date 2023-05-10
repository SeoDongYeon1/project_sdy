package com.KoreaIT.sdy.demo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class FileUploadRequestDto {

    private MultipartFile file;

    private String transaction;

    private String chatRoom;
}