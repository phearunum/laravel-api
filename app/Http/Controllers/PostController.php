<?php
namespace App\Http\Controllers;
use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{
    public function index()
    {
        return Post::all();
    }

    public function store(Request $request)
    {
        $post = Post::create($request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
        ]));

        return response()->json($post, 201);
    }

    public function show(Post $post)
    {
        return $post;
    }

    public function update(Request $request, Post $post)
    {
        $post->update($request->validate([
            'title' => 'sometimes|string|max:255',
            'content' => 'sometimes|string',
        ]));

        return $post;
    }

    public function destroy(Post $post)
    {
        $post->delete();
        return response()->noContent();
    }
}
