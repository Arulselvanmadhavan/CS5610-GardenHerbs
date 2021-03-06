﻿using System;
using System.Collections.Generic;

public partial class postComment
{
    public int commentid { get; set; }
    public Nullable<int> postId { get; set; }
    public string commentedUser { get; set; }
    public string wallName { get; set; }
    public Nullable<System.DateTime> commentedDate { get; set; }
    public string comments { get; set; }
    public string likedusers { get; set; }

    public virtual postmaster postmaster { get; set; }
}

public partial class postmaster
{
    public postmaster()
    {
        this.postComments = new HashSet<postComment>();
    }

    public int postid { get; set; }
    public string wallName { get; set; }
    public string postedBy { get; set; }
    public Nullable<System.DateTime> postedDate { get; set; }
    public string postContent { get; set; }
    public string likedusers { get; set; }

    public virtual ICollection<postComment> postComments { get; set; }
}