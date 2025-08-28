package org.awsboot.web;

import lombok.RequiredArgsConstructor;
import org.awsboot.service.PostsService;
import org.awsboot.web.dto.PostsListResponseDto;
import org.awsboot.web.dto.PostsResponseDto;
import org.awsboot.web.dto.PostsSaveRequestDto;
import org.awsboot.web.dto.PostsUpdateRequestDto;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class PostsApiController {

    private final PostsService postsService;

    @PostMapping("/api/v1/posts")
    public Long save(@RequestBody PostsSaveRequestDto requestDto){
        return postsService.save(requestDto);
    }

    @PutMapping("/api/v1/posts/{id}")
    public Long update(@PathVariable Long id, @RequestBody PostsUpdateRequestDto reqDto){
        return postsService.update(id, reqDto);
    }

    @DeleteMapping("/api/v1/posts/{id}")
    public Long delete(@PathVariable Long id){
        postsService.delete(id);
        return id;
    }

    @GetMapping("/api/v1/posts/{id}")
    public PostsResponseDto findById(@PathVariable Long id){
        return postsService.findById(id);
    }

    @GetMapping("/api/v1/posts/list")
    public List<PostsListResponseDto> findAll(){
        return postsService.findAllDesc();
    }

}
