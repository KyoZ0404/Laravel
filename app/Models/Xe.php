<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Xe extends Model
{
    protected $table = "xe";
    protected $primaryKey = "Mã";
    const CREATED_AT = "created_at";
    const UPDATED_AT = "updated_at";
}
