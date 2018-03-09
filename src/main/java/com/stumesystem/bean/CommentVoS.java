package com.stumesystem.bean;

import java.util.List;

public class CommentVoS {
    private Comments comments;      //直接根评论
    private List<Comments> root_directcomment;     //根评论下的直接评论
    private List<Comments> root_Ndirectcomment;       //根评论下直接评论的评论

    public Comments getComments() {
        return comments;
    }

    public void setComments(Comments comments) {
        this.comments = comments;
    }

    public List<Comments> getRoot_directcomment() {
        return root_directcomment;
    }

    public void setRoot_directcomment(List<Comments> root_directcomment) {
        this.root_directcomment = root_directcomment;
    }

    public List<Comments> getRoot_Ndirectcomment() {
        return root_Ndirectcomment;
    }

    public void setRoot_Ndirectcomment(List<Comments> root_Ndirectcomment) {
        this.root_Ndirectcomment = root_Ndirectcomment;
    }
}
