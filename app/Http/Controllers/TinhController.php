<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Tinh;
use App\Http\Controllers\FunctionBase;
class TinhController extends Controller
{
     //Phần tỉnh
     public function addprovince(Request $request) {
        $name = $request->name;
		$namekhongdau = FunctionBase::convertAlias($request->name);
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if($request->ID != ""){
            if(DB::update("UPDATE `tinh` SET `Tên`= ?, `Tên_không_dấu`= ?, `updated_at`= ? WHERE `Mã`= ?",
                [$name,$namekhongdau,$updated_at,$request->ID]))
                return \response()->json(['result'=>'1']);
            else
                return \response()->json(['result'=>'0']);
        }
        else {
            if( DB::insert("INSERT INTO `tinh`(`Tên`, `Tên_không_dấu`, `created_at`, `updated_at`) VALUES (?,?,?,?)",
                [$name,$namekhongdau,$created_at,$updated_at]))
            {
                return \response()->json(['result'=>'1']);
            }
            else
                return \response()->json(['result'=>'0']);
        }
    }
    public function delprovince(Request $request) {
        if(isset($request->ID)) {
            try {
                DB::delete('DELETE FROM tinh WHERE Mã = ?',[$request->ID]);
            } catch (\Exception $e) {
                return \response()->json(['result'=>'0']);
            }
            return \response()->json(['result'=>'1']);
        }
    }
}
